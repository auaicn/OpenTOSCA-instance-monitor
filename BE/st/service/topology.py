import requests
import json
import xml.etree.ElementTree as et
from .hostname import base_url

def get_xml(url):
    xml = requests.get(url)
    return xml.content

def nodes_to_json(nodes):
    ret = []

    for i in range(len(nodes)):
        ret.append({"id": i + 1, "label": nodes[i]})

    return ret

def edges_to_json(nodes, edges):
    ret = []
    for edge in edges:
        to_ = nodes.index(edge[0]) + 1
        from_ = nodes.index(edge[1]) + 1
        ret.append({"from": from_, "to": to_})

    return ret

def get_topology(url):
    nodes = []
    edges = []

    xml = get_xml(url)
    xml = et.fromstring(xml)

    for ServiceTemplate in xml:
        for TopologyTemplate in ServiceTemplate:
            for tmp in TopologyTemplate:
                
                if "NodeTemplate" in tmp.tag:
                    name = tmp.attrib["id"]
                    nodes.append(name)
                
                if "RelationshipTemplate" in tmp.tag:
                    # properties 껴있는거 작업하기
                    source = None
                    target = None

                    for t in tmp:
                        if "SourceElement" in t.tag: source = t.get("ref")
                        elif "TargetElement" in t.tag: target = t.get("ref")
                    edges.append((source, target))  

    nodes_json = nodes_to_json(nodes)
    edges_json = edges_to_json(nodes, edges)

    ret = json.dumps({"nodes": nodes_json, "edges": edges_json}, indent=2)
    return ret
