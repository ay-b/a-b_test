import web
import json
import random
from numpy.random import choice

urls = (
    '/', 'index',
    '/heartbeat', 'heartbeat'
)

class index:

    def GET(self):
        json_data = []
        #get the file data
        with open('rotator.json') as json_file:
            json_data = json.load(json_file) 
        data_len = len(json_data)
        #mapping responses and weights
        #creating a list of responses to get a random choice from
        responses = []
        weights = []
        rnd_list = []
        for x in json_data:
            resp = x["response"]
            wght = x["weight"]
            rnd_list.extend([resp] * wght) #here we place each resp multiply times into the list (according to its weight)
        return ''.join(random.choice(rnd_list))
        
class heartbeat:
    def GET(heartbeat):
        return "OK. Alive"

if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()



