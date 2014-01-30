class LcdDisplay
  def initialize(num, size=1)
    @num = num
    @size = size
  end

  def render
    lcd_nums = digits_to_lcd_nums

    0.upto 4 do |i|
      if i == 1 or i == 3
        (@size-1).times do
          render_line(i, lcd_nums)
        end
      end

      render_line(i, lcd_nums)
    end

  end


  private

  def render_line(i, lcd_nums)
    lcd_nums.each do |lcd_num|
      lcd_num.render_line_num(i)
      render_space
    end
    puts
  end

  def render_space
    num_spaces = @size/2 + 1
    num_spaces.times { print ' ' }
  end

  def digits_to_lcd_nums
    digits = @num.to_s.chars.map(&:to_i)
    
    lcd_nums = digits.map do |digit|
      LcdNum.new(digit, @size)
    end
  end

  def num_lines
    if @size == 1
      5
    else
      @size + 3
    end
  end
end

class LcdNum
  def initialize(num, size=1)
    @num = num
    @size = size 
  end

  def render
    graphics[@num].each_with_index do |line, index|
      if index == 1 or index == 3
        @size.times do
          render_line(line)
          puts
        end
      else
        render_line(line)
        puts
      end
    end
  end

  def render_line_num(num)
    line = graphics[@num][num]
    render_line(line)
  end

  private

  def render_line(line)
    line.split(//).each_with_index do |character, index|
      if character == '|' or first_or_last(line, index)
        print character
      else
        @size.times do
          print character
        end
      end
    end
  end
  
  def first_or_last(line, index)
    index == 0 or index == line.length-1
  end

  def graphics
    [
      [
       ' - ',
       '| |',
       '   ',
       '| |',
       ' - '
      ],
      [
       '   ', 
       '  |',
       '   ',
       '  |',
       '   '
      ],
      [
       ' - ',
       '  |',
       ' - ',
       '|  ',
       ' - '
      ],
      [
       '-- ', 
       '  |',
       '-- ',
       '  |',
       '-- '
      ],
      [
       '   ',
       '| |',
       ' - ',
       '  |',
       '   '
      ],
      [
       ' - ',
       '|  ',
       ' - ',
       '  |',
       ' - '
      ],
      [
       ' - ',
       '|  ',
       ' - ',
       '| |',
       ' - '
      ],
      [
       ' - ',
       '  |',
       '   ',
       '  |',
       '   '
      ],
      [
       ' - ',
       '| |',
       ' - ',
       '| |',
       ' - '
      ],
      [
       ' - ',
       '| |',
       ' - ',
       '  |',
       ' - '
      ] 
      
    ]
  end

end

LcdDisplay.new(1234567890, 3).render
