#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

frames.map do |frame|
  frame == [10, 0] && frame.delete_at(-1)
end

if !frames[11].nil?
  frames[9] = frames[9] + frames[10] + frames[11]
  frames.delete_at(-1)
  frames.delete_at(-1)
elsif frames[11].nil? && !frames[10].nil?
  frames[9] = frames[9] + frames[10]
  frames.delete_at(-1)
end

point = 0
frames.each_with_index do |frame, i|
  point += if frame == [10]
             if i + 1 == 9
               frames[i + 1].sum - frames[i + 1].last + 10
             elsif frames[i + 1] == [10] && frames[i + 2] == [10]
               frames[i + 1].sum + frames[i + 2].sum + 10
             elsif frames[i + 1] == [10] && frames[i + 2] != [10]
               frames[i + 1].sum + frames[i + 2].first + 10
             else
               frames[i + 1].sum + 10
             end
           elsif frame.sum == 10 && i + 1 != 10
             frames[i + 1].first + 10
           else
             frame.sum
           end
end

puts point
