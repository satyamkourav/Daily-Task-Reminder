# main_script.rb
require 'dotenv'
require_relative 'send_email'
require_relative 'update_name'

puts "In the main_script.rb file"

# Load environment variables from .env
Dotenv.load

mail_body_text = ""

# List of names in the order they should appear

names = ["name1", "name2"]


# Hash to store files name and person name
day_work = {}

def what_work_today()
    files_name = ["jh.md", "sa.md"]
    case Date.today.wday
    when 0 # Sunday
        files_name.push("po.md", "ka.md", "ba.md")
    when 2 # Tuesday
        files_name.push("ka.md")
    when 4 # Thursday
        files_name.push("ka.md")
    end
    files_name
end

# Update hash to contain file and person names
what_work_today.each do |name|
    last_name_index = names.index(File.readlines(name).last&.strip)
    day_work[name] = if last_name_index
        names[(last_name_index + 1) % names.length]
    else
        names.first
    end
end

# Update the respected files
day_work.each do |file, person|
    mail_body_text += "#{person}"
    case file
    when "jh.md" # Logic for "jh.md"
        mail_body_text += " ko aaj Jhadu lagana hai.\n"
    when "po.md" # Logic for "po.md"
        mail_body_text += " ko aaj Pocha lagana hai.\n"
    when "ka.md" # Logic for "ka.md"
        mail_body_text += " ko aaj Kachda fekna hai.\n"
    when "ba.md" # Logic for "ba.md"
        mail_body_text += " ko aaj Bathroom saaf karna hai.\n"
    when "sa.md"
        mail_body_text += " ko kal k liye Sabji laani hai.\n"
    else
    puts "No Work today."
    end
end

# Update names in files
update_name(day_work)

# Send email notification
send_email(mail_body_text)
