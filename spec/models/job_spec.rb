require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  apple = Employer.new(employer_name: 'Apple', email: 'apple@apple.com', bio: "IPhone XX ya dig")
  junior_swe = Job.new(title: 'Software Engineer',
       description: 'Code stuff fast pls', exp_level: 'Junior')

  apple.jobs << junior_swe

  it "should be valid with no salary" do
    expect(junior_swe).to be_valid
  end

  it "should not be valid with no description" do
    mid_swe = Job.new(title: 'Software Engineer', exp_level: 'Mid')
    expect(mid_swe).to_not be_valid
  end

  it "should not be valid with no Employer" do
    senior_swe = Job.new(title: 'Software Engineer', exp_level: 'Senior', description: 'Mentor Juniors pls')
    expect(senior_swe).to_not be_valid
  end
end
