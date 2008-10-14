# This scenario is just to override the corresponding scenario in Radiant 0.6.9
# that gave this error the second and following times the spec was run:
#   /Library/Ruby/Gems/1.8/gems/radiant-0.6.9/spec/scenarios/file_not_found_scenario.rb:2:
#  superclass mismatch for class CustomFileNotFoundPage (TypeError)
#
# I just commented out all the CustomFileNotFoundPage references to make it work.



require 'file_not_found_page'
# class CustomFileNotFoundPage < FileNotFoundPage
# end

class FileNotFoundScenario < Scenario::Base
  uses :home_page
  
  def load
    create_page "Draft File Not Found", :class_name => "FileNotFoundPage", :status_id => Status[:draft].id
    create_page "File Not Found", :slug => "missing", :class_name => "FileNotFoundPage"
    # create_page "Gallery" do
    #   create_page "Draft No Picture", :class_name => "CustomFileNotFoundPage", :status_id => Status[:draft].id
    #   create_page "No Picture", :class_name => "CustomFileNotFoundPage"
    # end 
    create_page "Drafts" do
      create_page "Lonely Draft File Not Found", :class_name => "FileNotFoundPage", :status_id => Status[:draft].id
    end
  end
end