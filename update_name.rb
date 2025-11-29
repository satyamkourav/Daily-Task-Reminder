# update_name.rb
def update_name(day_work)
    puts "In the update_name.rb file"
    day_work.each do |file_name, name_to_add|
        # Read the current names from the file
        names = File.read(file_name).split("\n")
    
        # Append the new name to the file
        names << name_to_add
    
        # Write the updated names back to the file
        File.open(file_name, 'w') do |file|
        file.puts(names)
        end
    
        puts "Added '#{name_to_add}' to #{file_name}"
    end
end
  
