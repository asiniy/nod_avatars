class PagesController < ApplicationController
  def root
    @photos = Photo.published.order('id DESC')
  end
end
