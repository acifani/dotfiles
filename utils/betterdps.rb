#!/usr/bin/env ruby
require 'json'

module DockerHelper
  @@colors = {
    container: 34,
    container_running: 32,
    container_stopped: 31,
    hash: 33,
    image: 34,
    ip: 36,
    image_ubuntu: 202,
    ports: 241,
    tag: 241
  }

  def color(type)
    @@colors[type]
  end

  def image_color(image)
    color_symbol = ('image_' + image.tr('-', '_')).to_sym
    return @@colors[color_symbol] if @@colors[color_symbol]
    @@colors[:image]
  end

  def colorize(text, color)
    color = format('%03d', color)
    "\033[0;#{color}m#{text}\033[0m"
  end

  def longest_by_type(list, type)
    ordered = list.map { |obj| obj[type] }.group_by(&:size)
    return nil if ordered.empty?
    ordered.max.last[0]
  end
end

Container = Struct.new(:name, :hash, :image, :ports, :is_running)
# Display the list of current docker containers
class DockerContainerList
  include DockerHelper

  def initialize(*args)
    @args = args
    @container_list = container_list
  end

  def container_list
    options = [
      'docker',
      'inspect',
      '$(docker ps -qa)'
    ]
    output = `#{options.join(' ')}`
    containers = []
    containers << Container.new('Name', 'Hash', 'Image', 'Ports', 'Status')
    json_containers = JSON.parse(output)
    json_containers.each do |container|
      name = container['Name'][1,container['Name'].length]
      hash = container['Id'][0,12]
      image = container['Config']['Image']
      filter_ports = remove_useless_string_in_values(container['NetworkSettings']['Ports'].keys, ['/tcp', '/udp'])
      filter_ports.sort
      ports = filter_ports.join(' ')
      status = container['State']['Running']

      if image.include? "mesos"
        image = "[mesos] " + image[31,image.length]
      end
      containers << Container.new(name, hash, image, ports, status)
    end
    containers.sort_by do |c|
      [c[:is_running] ? 0 : 1, c[:name]]
    end
  end

  def remove_useless_string_in_values(array, strings_to_remove)
    result = []

    strings_to_remove.each do |to_remove|
      array.each do |port|
        result << port.gsub(to_remove, '').to_i
      end
    end
    
    return result.uniq.sort
  end  

  def output_name(container)
    if container[:is_running] == 'Status'
      icon = '  '
      color = color(:container_running)
    elsif container[:is_running]
      icon = '✅ '
      color = color(:container_running)
    else
      icon = '🛑 '
      color = color(:container_stopped)
    end
    name = container[:name].ljust(longest_name_length)
    colorize("#{icon} #{name}", color)
  end

  def longest_name_length
    @container_list.map { |obj| obj[:name] }.group_by(&:size).max.last[0].length
  end

  def longest_image_length
    @container_list.map { |obj| obj[:image] }.group_by(&:size).max.last[0].length
  end

  def longest_ip_length
    @container_list.map { |obj| obj[:ports] }.group_by(&:size).min.last[0].length
  end

  def longest_hash_length
    @container_list.map { |obj| obj[:hash] }.group_by(&:size).max.last[0].length
  end

  def output_hash(container)
    hash = container[:hash].ljust(longest_hash_length)
    colorize(hash, color(:hash))
  end

  def output_ports(container)
    ports = container[:ports].ljust(longest_ip_length)
    colorize(ports, color(:ports))
  end

  def output_image(container)
    image = container[:image].ljust(longest_image_length)
    colorize(image, color(:image))
  end

  def run
    @container_list.each do |container|
      name = output_name(container)
      hash = output_hash(container)
      image = output_image(container)
      ports = output_ports(container)
      puts "#{name} #{image} #{hash} #{ports}"
    end
  end
end
DockerContainerList.new(*ARGV).run

