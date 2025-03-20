import os, sys, platform, pdb
from pathlib import Path

ovf_exe = os.path.join(os.getenv("MY_BINARY_DIR"),"ovf")

current_file_dir = os.path.dirname(__file__)

sys.path.append(os.path.join(current_file_dir, 'submodules/pyOpenViewFactor'))
import RunOVF

bricks_dir = os.path.join( current_file_dir , "assets/bricks" )
shoes_dir = os.path.join( current_file_dir , "assets/hot-shoes" )
logs_dir = os.path.join( current_file_dir , "logs" )

all_bricks = os.listdir(bricks_dir)
all_hot_shoes = os.listdir(shoes_dir)

system = platform.system()

if system == "Windows":
  path_split_character = "\\"
elif system == "Linux":
  path_split_character = "/"

for brick in all_bricks:
  for shoe in all_hot_shoes:
    log_name = brick[:-4] + "--" + shoe[:-4]
    log_output_path = os.path.join( logs_dir , log_name )

    brick_path = os.path.join( bricks_dir , brick )
    shoe_path = os.path.join( shoes_dir , shoe )

    RunOVF.RunOVF(
      OVF_EXE_PATH = ovf_exe,
      inputs = [ brick_path , shoe_path ],
      logfile = log_output_path
    )

    log_contents = Path(log_output_path + ".txt").read_text()
    result = float(log_contents.split("[RESULT] ")[1].split("[LOG]")[0].split(':')[1])

    print(f"Surface-Surface View Factor:\t {result}")

    breakpoint()