namespace :task_autocreation do
  desc "Create tasks"
  task :create_tasks => :environment do

    def convert_frequency_to_days(frequency)
      case frequency
      when 'daily'
        1
      when 'weekly'
        7
      when 'monthly'
        30
      when 'yearly'
        365
      else
        raise ArgumentError, "Invalid frequency: #{frequency}"
      end
    end

    Task.where(repeat_task: true).each do |task|

      interval = convert_frequency_to_days(task.frequency)
      current_date = Date.current
      start_date = task.start_date + interval

      puts task.name

      if start_date <= task.due_date
        date_range = (start_date..current_date.at_end_of_week).step(interval).to_a 
        new_tasks = date_range.map do |date| 
          puts date
          if date <= task.due_date
            Task.create(
              name: task.name,
              assignee_id: task.assignee_id,
              approver_id: task.approver_id,
              organization_id: task.organization_id,
              status: 'todo',
              description: task.description,
              start_date: date,
              end_date: date + interval,
              repeat_task: task.repeat_task,
              frequency: task.frequency,  
              due_date: task.due_date
            )
          end
        end
        task.update(repeat_task: false)
        new_tasks.compact[0...-1].each { |new_task| new_task.update(repeat_task: false) }
      end
    end
  end
end
