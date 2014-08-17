import json
import sys
import yaml

data = yaml.load(sys.stdin)
json.dump(data, sys.stdout, indent=4)
