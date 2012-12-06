require "musts/version"
require "musts/object_extension"
require "musts/must"
require "musts/matchers/default_matcher"
require "musts/matchers/be_matcher"
require "musts/matchers/close_matcher"

module Musts
  class Failure < StandardError; end

  def self.matcher(*args, &block)
    Must.matcher(*args, &block)
  end

  matcher(:equal, :eq) { |other| self == other }
  matcher(:match)      { |other| self =~ other }
  matcher(:be_true)    { self }
  matcher(:be_false)   { !self }
  matcher(:be_nil)     { nil? }
  matcher(:include)    { |*args| include?(*args) }

  matcher(:be_greater_than, :be_gt)              { |other| self > other }
  matcher(:be_greater_than_or_equal_to, :be_gte) { |other| self >= other }
  matcher(:be_less_than, :be_lt)                 { |other| self < other }
  matcher(:be_less_than_or_equal_to, :be_lte)    { |other| self <= other }

  matcher(:be, BeMatcher)
  matcher(:be_close_to, CloseMatcher)

  matcher(:raise_exception) do |*args|
    raised = false
    exception = args.first || StandardError
    begin
      call
    rescue exception
      raised = true
    end
    raised
  end
end
