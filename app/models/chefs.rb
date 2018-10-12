class Chef < ActiveRecord::Base
  has_many :dishes

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Chef.all.find{|chef| chef.slug == slug}
  end
end
