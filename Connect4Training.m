clear agent
env = createConnect4Env()
agent = load(".\basicAgent.mat")
agent = agent.agent
agent = mytrain(agent,env)

env = createConnect4Env()

agent = mytrain(agent,env)