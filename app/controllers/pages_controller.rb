class PagesController < ApplicationController
  def root
    @photos = Photo.published.order('id DESC').limit(20)
  end
end
