class ItemClassifierService < ApplicationService
  private

  CLASSIFIER_BASE_URL =
    "https://api.uclassify.com/v1/uclassify/iab-taxonomy-v2/classify?readkey=#{ENV["UCLASSIFY_READKEY"]}"

  attr_reader :description

  def initialize(description:)
    @description = description
  end

  def execute
    return if description.blank?

    get_item_classification
  end

  def get_item_classification
    http_call.sort_by { |k, v| v }.last[0]
  end

  # TODO Create a uClassify Gateway and better encapsulate this logic
  def http_call
    url = CLASSIFIER_BASE_URL + "&text=" + description

    JSON.parse HTTParty.get(url).body
  end
end
