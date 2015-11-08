class LineAnalyzer
  
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency

    word_frequency = Hash.new(0)

    @content.split.each do |word|
      word_frequency[word.downcase] +=1
    end

    @highest_wf_count = word_frequency.values.max
    @highest_wf_words = word_frequency.select { |k, v| k if v == word_frequency.values.max }.keys
  end
end

class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
    
  end

  def analyze_file

    line_number = 1

    File.foreach("test.txt") do |line|
      @analyzers << LineAnalyzer.new(line.chomp, line_number)
      line_number += 1
    end

  end 

  
  def calculate_line_with_highest_frequency

    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []

    @analyzers.each do |line|
      if ( line.highest_wf_count > @highest_count_across_lines)
        @highest_count_across_lines = line.highest_wf_count
      end
    end

    @analyzers.each do |line|
      if (line.highest_wf_count == @highest_count_across_lines)
        @highest_count_words_across_lines << line
      end
    end

    print_highest_word_frequency_across_lines
  end


  def print_highest_word_frequency_across_lines
    puts "The following words have highest frequency per line:" 

    @highest_count_words_across_lines.each do |line_analyzer|
      puts "#{line_analyzer.highest_wf_words} (appears in line #{line_analyzer.line_number})"
    end
  end
end
