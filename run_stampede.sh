
# list of components we want to benchmark.  For each component, we will create
# a config which configures the blowup mechanism to load just that component.
# We will then run that config repeatedly (for stats) and collect the profles.
COMPONENTS='inp'
COMPONENTS='out'
COMPONENTS='inp sch exe out'
COMPONENTS='exe'
COMPONENTS='out'
COMPONENTS='any'

# number of repetitions
REPS=1

# target resource : cores per node
RESOURCES='stampede:16 local'
RESOURCES='local'
RESOURCES='comet:24'
RESOURCES='stampede:16'


# compute unit load
# CU_LOAD='sleep_%s.json'
CU_LOAD='mdrun_50000_8.json'

# experiment sizes (make sure it fits into the queue limits after the agent
# nodes were added)
# SIZES='128: 256: 512: 1024:'
SIZES='500:normal'

# number of components per sub agent
WORKERS='1 2 4 8'
WORKERS='1'

# number of sub agents to use
AGENTS='1 2 4 8'
AGENTS='1'

# agent layout to use
# simple_n describes a layout where n sub-agents all have a full set of
# $WORKER agent components -- AgentWorker and AgentSchedulingComponent remain
# singletons in agent_0 though
AGENT_CFG_TMPL='agent_config.tmpl'

# fixed parameters
RUNTIME=30

# staging file sizes
FILES='0 1 1K 1M'
FILES='0'

