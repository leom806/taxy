class ReceiptsController < ApplicationController
  before_action :set_receipt, only: %i[show edit update destroy export]

  def index
    @q = Receipt.ransack(params[:q])
    @pagy, @receipts = pagy ReceiptsListQuery.query(relation: @q.result)
  end

  def insights
    @receipts_hourly = Receipt.group_hourly.count
    @receipts_items = ReceiptItem.count_by_receipt.map { |k, v| ["Receipt ##{k}", v] }
  end

  def show
    @default_currency = ::Currency.default_formatted
    @rates = ::Currency.all_formatted
  end

  def new
    @receipt = Receipt.new
    10.times { @receipt.receipt_items.build }
    @items = @receipt.receipt_items.to_a
  end

  def create
    @receipt =
      ::GenerateReceiptService.execute(items: receipt_params[:receipt_items_attributes])

    if @receipt
      redirect_to receipt_url(@receipt), notice: "Receipt was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @receipt.soft_delete!

    redirect_to receipts_url, notice: "Receipt was successfully destroyed."
  end

  def export
    send_data render_to_string(
                template: "receipts/export",
                layout: false,
                locals: {
                  receipt: @receipt
                }
              ),
              filename: "Receipt ##{@receipt.id}.txt",
              type: "text/plain"
  end

  private

  def set_receipt
    @receipt = Receipt.not_deleted.find(params[:id])
  end

  def receipt_params
    params.require(:receipt).permit(
      receipt_items_attributes: %i[amount quantity description]
    )
  end
end
