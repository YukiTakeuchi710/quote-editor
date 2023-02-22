class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  # 個別のQuoteのリストを表示
  def index
    @quotes = Quote.all
  end

  # 個別のQuoteを表示
  def show
  end

  def new
    @quote = Quote.new
  end

  # quoteを追加
  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      redirect_to quotes_path, notice: "Quote was successfully created."
    else
      # note: TurboDriveを採用した
      # 　Rails7での大きな変更
      #   formがvalidateにかかるなどのエラーが起きた場合に
      #
      # render :new
      # Add `status: :unprocessable_entity` here
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote was successfully updated."
    else
      # Add `status: :unprocessable_entity` here
      render :edit, status: :unprocessable_entity
    end
  end

  # quoteを削除
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
