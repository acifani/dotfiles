#!/usr/bin/env ruby

module DockerHelper
  @@colors = {
    container: 34,
    container_running: 32,
    container_stopped: 31,
    hash: 33,
    image: 34,
    size: 36,
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

Image = Struct.new(:name, :tag, :hash, :size)
# Display the list of current docker images
class DockerImageList
  include DockerHelper

  def initialize(*args)
    @args = args
    @image_list = image_list
  end

  def image_list
    options = [
      'docker',
      'images',
      @args.join(' ')
    ]
    output = `#{options.join(' ')}`
    images = []
    images << Image.new('[-reg-] Name', 'Tag', 'Hash', 'Size')
    output.each_line.with_index do |line, index|
      next if index == 0
      name, tag, hash, _, _, _, si, ze = line.split(' ').compact
      if name.include? "mesos"
        name = "[mesos] " + name[31,name.length]
      elsif name.include? "containers.schibsted.io"
        name = "[artif] " + name[24, name.length]
      elsif
        name = "[-std-] " + name
      end
      images << Image.new(name, tag, hash, si.to_s + ' ' + ze.to_s)
    end
    images.sort_by do |i|
      [i[:name], i[:tag]]
    end
  end

  def longest_name_length
    @image_list.map { |obj| obj[:name] }.group_by(&:size).max.last[0].length
  end

  def longest_tag_length
    @image_list.map { |obj| obj[:tag] }.group_by(&:size).max.last[0].length
  end

  def longest_hash_length
    @image_list.map { |obj| obj[:hash] }.group_by(&:size).max.last[0].length
  end

  def output_name(image)
    colorize(image[:name].ljust(longest_name_length), color(:image))
  end

  def output_tag(image)
    colorize(image[:tag].ljust(longest_tag_length), color(:tag))
  end

  def output_hash(image)
    colorize(image[:hash].ljust(longest_hash_length), color(:hash))
  end

  def output_size(image)
    colorize(image[:size], color(:size))
  end

  def run
    @image_list.each do |image|
      name = output_name(image)
      tag = output_tag(image)
      hash = output_hash(image)
      size = output_size(image)
      puts "#{name} #{tag} #{hash} #{size}"
    end
  end
end

DockerImageList.new(*ARGV).run

