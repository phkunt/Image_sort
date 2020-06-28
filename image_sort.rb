#!/usr/bin/env ruby
# frozen_string_literal: true

require 'exifr/jpeg'
require 'fileutils'
require 'colorize'

def get_timestamp(path)
  return EXIFR::JPEG.new(path).date_time.to_s
end

def get_type(path)
  return path.split('.').last
end

def select_mounted_volumes
  puts "Select a backup volume. Mounted volumes:".yellow
  volumes = Dir.entries('/Volumes').select {|entry| File.directory? File.join('/Volumes',entry) and !(entry =='.' || entry == '..' || entry == 'APPLE SSD' || envry == 'Windows' || entry == 'Recovery') }
  puts volumes
  puts ""
  backup_volume = gets.chomp 
  if !volumes.include? backup_volume
    puts "Invalid Input!"
    exit(1)
  end
  backup_volume
end

def create_folder(filetype, timestamp)
  dir = check_dir_exists(filetype, timestamp)
    if dir
      FileUtils.mkdir_p "#{dir}" 
      puts "Directory: #{dir} created!".green
    end
  return "#{ENV['HOME']}/Pictures/#{filetype}/#{timestamp[0..3]}/#{timestamp[5..6]}/#{timestamp[8..9]}"
end

def check_dir_exists(filetype, timestamp)
  destination_path = "#{ENV['HOME']}/Pictures/#{filetype}/#{timestamp[0..3]}/#{timestamp[5..6]}/#{timestamp[8..9]}"

  if !Dir.exists?(destination_path)
    destination_path
  end
end

def move_file(origin_path, destination_path)
  puts "Moving #{origin_path.split("/").last} to #{destination_path} ..."
  FileUtils.cp(origin_path, destination_path)
end

def backup(file_path, volume, timestamp, filetype)
  backup_path = "/Volumes/#{volume}/Pictures/#{filetype}/#{timestamp[0..3]}/#{timestamp[5..6]}/#{timestamp[8..9]}"
  if !Dir.exists?(backup_path)
    FileUtils.mkdir_p "#{backup_path}"
    puts "Backup directory: #{backup_path} created!".green
  end
  puts "Backing up #{file_path.split("/").last}"
  FileUtils.mv(file_path, backup_path)
end

sort_path = "#{ENV['HOME']}/Pictures/toSort"
volume = select_mounted_volumes
puts "Start:".green

Dir.foreach(sort_path) do |filename|
  next if (filename == '.') || (filename == '..')

  path = "#{ENV['HOME']}/Pictures/toSort/#{filename}"
  timestamp = get_timestamp(path)
  filetype = get_type(path)
  destination_path = create_folder(filetype, timestamp)
  move_file(path, destination_path)
  backup(path, volume, timestamp, filetype)
end
puts "Done!".green

