# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cdr, :class => 'Cdrs' do
    portal "MyString"
    time "MyString"
    size "MyString"
  end
end
