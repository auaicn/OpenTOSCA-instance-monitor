import requests

base_url = "http://ec2-3-35-68-199.ap-northeast-2.compute.amazonaws.com:1337/csars/"

def csars():

    response = requests.get(base_url)

    return response.json().get("csars")


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
        
        for tmp in response:
            id = tmp.get("id")
            ret[name].append(id)
            ret_[id] = []

    return ret, ret_
