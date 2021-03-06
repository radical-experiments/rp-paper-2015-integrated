
# list of components we want to benchmark.  For each component, we will create
# a config which configures the blowup mechanism to load just that component.
# We will then run that config repeatedly (for stats) and collect the profles.
COMPONENTS='exe'
COMPONENTS='inp'
COMPONENTS='out'
COMPONENTS='inp sch exe out'

# number of repetitions
REPS=1

# target resource : cores per node
RESOURCES='stampede:16 local'
RESOURCES='local'
RESOURCES='comet:24'


# compute unit load
# CU_LOAD='sleep_%s.json'
CU_LOAD='cu_true.json'

# experiment sizes (make sure it fits into the queue limits after the agent
# nodes were added)
# SIZES='128: 256: 512: 1024:'
SIZES='1024:'
SIZES='250:normal 500:normal 1000:normal'
SIZES='250:normal 1000:normal'
SIZES='256: 512: 1024: 2048:'
SIZES='256:'
SIZES='250:compute'
SIZES='250:compute 500:compute 1000:compute'

# number of components per sub agent
WORKERS='1'
WORKERS='1 2 4 8'

# number of sub agents to use
AGENTS='2'
AGENTS='1 2 4 8'

# agent layout to use
# simple_n describes a layout where n sub-agents all have a full set of
# $WORKER agent components -- AgentWorker and AgentSchedulingComponent remain
# singletons in agent_0 though
AGENT_CFG_TMPL='agent_simple.tmpl'

# fixed parameters
RUNTIME=10

# staging file sizes
FILES='0 1 1K 1M'
FILES='0'

