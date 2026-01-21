class EntriesController < ApplicationController
  # Add a before_action to find the entry for show, edit, update, and destroy
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]

  # Use HTTP Basic Auth for all actions except the public-facing index and show pages
  # The credentials will be stored securely in Rails credentials
  # TODO: Set up Rails credentials for CMS authentication
  # http_basic_authenticate_with(
  #   name: Rails.application.credentials.dig(:cms, :username),
  #   password: Rails.application.credentials.dig(:cms, :password),
  #   except: [:index, :show]
  # )

  def index
    # Only show published entries to the public
    @entries = Entry.published.order(date: :desc)
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to @entry, notice: "Entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: "Entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: "Entry was successfully destroyed."
  end

  private

  def set_entry
    @entry = Entry.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to entries_path, alert: "Entry not found"
  end

  def entry_params
    params.require(:entry).permit(:date, :body, :image)
  end
end
