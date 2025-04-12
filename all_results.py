import os, sys, pandas, platform, pdb
from pathlib import Path

current_file_dir = os.path.dirname(__file__)

system = platform.system()

if system == "Windows":
  path_split_character = "\\"
elif system == "Linux":
  path_split_character = "/"

logs_dir = os.path.join( current_file_dir , "logs" )

all_levels = os.listdir(logs_dir)

for level in all_levels:

  all_logs = os.listdir( os.path.join( logs_dir , level ) )

  brick_rows = []
  shoe_rows = []
  shoe_columns = []
  results = []
  for log in all_logs:
    brick_row = int( log.split("-")[2] )
    shoe_row = int( log.split("-")[-1][:-4] )
    shoe_face_label = ( log.split("-")[-3] ).split("_")[0]
    if shoe_face_label == "x":
      shoe_column = 4
    elif shoe_face_label == "left":
      shoe_column = 2
    elif shoe_face_label == "right":
      shoe_column = 3
    elif shoe_face_label == "y":
      shoe_column = 1

    log_contents = Path( os.path.join( logs_dir , level , log ) ).read_text()
    result = float(log_contents.split("[RESULT] ")[1].split("[LOG]")[0].split(':')[1])
    
    brick_rows.append(brick_row)
    shoe_rows.append(shoe_row)
    shoe_columns.append(shoe_column)
    results.append(result)

  data = {
    "brick row": brick_rows,
    "shoe column": shoe_columns,
    "shoe row": shoe_rows,
    "results": results
  }

  df = pandas.DataFrame(data)
  df.to_csv("all_results" + level + ".csv")