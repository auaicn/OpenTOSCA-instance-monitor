import requests

base_url = "http://localhost:1337/csars/"

def csars():
    response = requests.get(base_url)
    return response.json().get("csars")

def services():
    return [t.get("id")[:-5] for t in csars()]

def instances():
    csar = csars()
    return [t.get("id") for t in csar]

def ids():
    instance = instances()
    ret = {}
    ret_ = {}
    for name in instance:
        url = base_url + name + "/servicetemplates/" + name[:-5] + "/instances/"
        response = requests.get(url).json().get("service_template_instances")
        ret[name] = []
        
        if response is None: continue

        for tmp in response:
            id = tmp.get("id")
            ret[name].append(id)
            ret_[id] = {}
            
    return ret, ret_