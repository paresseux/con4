Shoes.app :width => 900, :height => 725 do
  blue = "#0000FF"
  red = rgb(255,0,0)
  black = rgb(0,0,0) 
  yellow = rgb(255,255,0)
 
  
  @board = []
  @columns = [[],[],[],[],[],[],[],[]]
  @picked = []
  @turn = 0

  7.times do |row|
    8.times do |column|
      r = rect 100 * column+5,
               100 * row+5, 100, 100, :fill => blue
      @board << r
      @columns[column] << row
    end
  end

  animate(2) do
    button, x,y = self.mouse

    column = x / 100
    row = y / 100

    if button == 1
      space = (@columns[column].first*8)+column
      if !@picked.include?(space)
	    
        @turn+=1
		
		if (@turn % 3 == 2)
		  color = black
		else
		  color = red
		end
		if (@turn % 3 == 0)
		  color = yellow
		end
		
		
        @board[space].style(:fill => color)
        @picked << space
        @columns[column].shift
        if solved?(color)
          alert("#{color} wins!")
        end
      end
    end
  end

  def solved?(color)
    if vertical_win(color) || horizontal_win(color)
      return true
    else
      return false
    end
  end

  def horizontal_win(color)
    7.times do |row|
      current_row = @board[(row*8)..(row*8+7)]
      continuous_row_count = 0
      position = 0
      while(position < current_row.length && continuous_row_count != 5) do
        if(current_row[position].style[:fill] == color)
          continuous_row_count += 1
        else
          continuous_row_count = 0
        end
        position+= 1
      end

      if continuous_row_count >= 5
        return true
      end
    end
    false
  end

  
  
  def vertical_win(color)
    8.times do |column|
	  current_column = [0,8,16,24,32,40,48].collect{|num| @board[column+num]}
      current_column = current_column.drop_while{|rect| rect.style[:fill] != color}
      current_column = current_column.take_while{|rect| rect.style[:fill] == color}
	  
	  if current_column.count >= 5
        return true
      end
	  
	end
		
	false
  end
 

 
end