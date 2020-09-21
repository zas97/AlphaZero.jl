module Game2048
  export Game, Board
  include("game.jl")
  module Training
    using AlphaZero
    include("params.jl")
  end
end