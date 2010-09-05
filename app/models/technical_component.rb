class TechnicalComponent < ActiveRecord::Base
  belongs_to :buildable, :polymorphic => true, :dependent => :destroy
end
