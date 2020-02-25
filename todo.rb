require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{display_status} #{todo_text} #{display_date}"
  end

  def self.show_list
    puts "My Todo-list \n \n"
    puts all.map { |todo| todo.to_displayable_string }
  end
  def self.add_task(new_todo)
    text = new_todo[:todo_text]
    date = Date.today + new_todo[:due_in_days]
    Todo.create(todo_text: text, due_date: date)
  end

  def self.mark_as_complete!(id)
    todo = Todo.find(id)
    todo.completed = true
    todo.save
    return todo
  end
end
