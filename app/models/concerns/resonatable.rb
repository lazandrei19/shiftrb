module Resonatable
  include Resonance

  resonate :user, with: :user, by: :follow
end