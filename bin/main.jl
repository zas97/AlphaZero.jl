#####
##### Main script for the JuliaCon 2020 demo
#####

@everywhere ENV["JULIA_CUDA_MEMORY_POOL"] = "split" # "binned" / "split"

# Enables running the script on a distant machine without an X server
@everywhere ENV["GKSwstype"]="nul"

using AlphaZero

@everywhere const DUMMY_RUN = false
@everywhere include("/home/jrun/AlphaZero.jl/scripts/lib/dummy_run.jl")

@everywhere include("/home/jrun/AlphaZero.jl/games/connect-four/main.jl")
@everywhere using .ConnectFour: Game, Training

params, benchmark = Training.params, Training.benchmark
if DUMMY_RUN
  params, benchmark = dummy_run_params(params, benchmark)
end

session = Session(
  Game,
  Training.Network{Game},
  params,
  Training.netparams,
  benchmark=benchmark,
  dir="sessions/connect-four",
  autosave=true,
  save_intermediate=false)

resume!(session)
