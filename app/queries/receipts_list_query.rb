class ReceiptsListQuery < ApplicationQuery
  private

  attr_reader :relation

  def initialize(relation: ::Receipt.all)
    @relation = relation
  end

  def query
    relation.all.not_deleted.includes(:receipt_items).order(id: :desc)
  end
end
