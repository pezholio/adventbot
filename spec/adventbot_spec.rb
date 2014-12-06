require 'spec_helper'

describe "Adventbot" do

  it "tweets the correct number of days until Christmas" do
    (1..23).each do |i|
      Timecop.freeze(Date.new(Date.today.year, 12, i))
      expect(Adventbot.twitter).to receive(:update).with("There are #{25 - i} days to go until Christmas!")
      expect(Adventbot.twitter).to receive(:update_profile_image)
      Adventbot.tweet
      Timecop.return
    end
  end

  it "tweets a different message on Christmas Eve" do
    Timecop.freeze(Date.new(Date.today.year, 12, 24))
    expect(Adventbot.twitter).to receive(:update_profile_image)
    expect(Adventbot.twitter).to receive(:update).with("Just one day to go until Christmas! How exciting!")
    Adventbot.tweet
    Timecop.return
  end

  it "tweets a different message on Christmas Day" do
    Timecop.freeze(Date.new(Date.today.year, 12, 25))
    expect(Adventbot.twitter).to receive(:update_profile_image)
    expect(Adventbot.twitter).to receive(:update).with("Merry Christmas!!")
    Adventbot.tweet
    Timecop.return
  end

  it "doesn't tweet after Christmas day" do
    (26..31).each do |i|
      Timecop.freeze(Date.new(Date.today.year, 12, i))
      expect(Adventbot.twitter).to_not receive(:update)
      Adventbot.tweet
      Timecop.return
    end
  end

  it "doesn't tweet outside of December" do
    (1..11).each do |i|
      Timecop.freeze(Date.new(Date.today.year, i, 1))
      expect(Adventbot.twitter).to_not receive(:update)
      Adventbot.tweet
      Timecop.return
    end
  end

  it "tweets sucessfully", :vcr do
    a = Adventbot.twitter.update("Here's a test")
    expect(a.url).not_to be_nil
  end

  # it "changes the profile picture every day" do
  #   (1..25).each do |i|
  #     Timecop.freeze(Date.new(Date.today.year, 12, i))
  #     expect(Adventbot.twitter).to receive(:update)
  #     expect(Adventbot.twitter).to receive(:update_profile_image)
  #     Adventbot.tweet
  #     Timecop.return
  #   end
  # end

end
