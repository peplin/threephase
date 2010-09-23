require 'spec_helper'

describe AllowedTechnicalComponentType do
  it { should have_db_index :buildable_id }
  it { should have_db_index :game_id }
  it { should belong_to :game }
  it { should belong_to :buildable }
  it { should validate_presence_of :game }
end
