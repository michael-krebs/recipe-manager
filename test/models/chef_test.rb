require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "John", email: "john@example.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email should be in a valid format" do
    valid_addresses = %w[user@aaa.com R_TTD-DS@aaa.hello.org first.last@example.net]
    valid_addresses.each do |v|
      @chef.email = v
      assert @chef.valid?, "#{v.inspect} should be valid"
    end
  end

  test "email should not be invalid" do
    invalid_addresses = %w[user@example,com user_at_website.org user.name@example. foo@aa+bb.com]
    invalid_addresses.each do |inv|
      @chef.email = inv
      assert_not @chef.valid?, "#{inv.inspect} should be invalid"
    end
  end

end