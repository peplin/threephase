class Repair < ActiveRecord::Base
  belongs_to :repairable, :polymorphic => true

  def repairable_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end
end
