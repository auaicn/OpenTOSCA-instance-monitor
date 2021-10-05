from fetch_ids import ids
import re
import json

file_name = "container_log.log"
date_regex = r"20[0-9][0-9]-[0-9][0-9]-[0-3][0-9] "
time_regex = "\d\d:\d\d:\d\d.\d\d\d"

csar_instance_dict = None
instance_container_dict = None

def read_container_log_file():
    f = open(file_name, "r")
    log = f.read()
    f.close()
    return log

def log_parsing():    
    # 날짜를 확인 시키고 그 단위로 끊어보자
    log = read_container_log_file()
    
    return re.split(date_regex + time_regex, log)

def main():
    global csar_instance_dict, instance_container_dict
    csar_instance_dict, instance_container_dict = ids()
    
    logs = log_parsing()

    for l in logs:
        if "SERVICEINSTANCEID_URI" in l and "ContainerID" in l:
            x = re.split(r': ', l)
            xml_string = x[-1]
            xml_key = re.findall(r"<key>(.+?)</key>", xml_string)
            xml_value = re.findall(r"<value>(.+?)</value>", xml_string)

            xml = {xml_key[i] : xml_value[i] for i in range(len(xml_key))}
            container_id = xml.get("ContainerID")

            x = re.findall(r'SERVICEINSTANCEID_URI=(.+?),', l)
            uri = x[0].split('/')
            instance_id = int(uri[-1])

            instance_container_dict[instance_id].append(container_id)

    print(json.dumps(csar_instance_dict, indent=4))
    print(json.dumps(instance_container_dict, indent=4))            

main()
'''
2021-10-01 12:58:08.846 INFO  [default-workqueue-1] o.o.b.m.a.s.processor.RequestProcessor   : serviceInstanceID:http://172.31.58.131:1337/csars/d1_w1-wip1.csar/servicetemplates/d1_w1-wip1/instances/13
'''

'''
2021-10-01 12:58:24.532 INFO  [default-workqueue-1] o.a.c.services.CallbackPortType.REQ_OUT  : REQ_OUT
    Address: http://engine-plan:9763/ode/processes/d1_w1-wip1.csarCallbackService1633092923691
    HttpMethod: POST
    Content-Type: text/xml
    ExchangeId: b19d4d02-8296-42fe-90c0-2ed3a309ef79
    ServiceName: CallbackService
    PortName: CallbackPort
    PortTypeName: CallbackPortType
    Headers: {SOAPAction=http://siserver.org/invokeOperationAsync, TRIGGERINGCONTAINER_STRING=172.31.58.131, DEPLOYMENT_ARTIFACTS_STRING={}, SERVICEINSTANCEID_URI=http://172.31.58.131:1337/csars/d1_w1-wip1.csar/servicetemplates/d1_w1-wip1/instances/13, Action=http://siserver.org/invokeOperationAsync, NODETEMPLATEID_STRING=DockerEngine_w1_0, User-Agent=Axis2, ARTIFACTREFERENCES_LISTSTRING=[http://172.31.58.131:1337/csars/d1_w1-wip1.csar/content/artifacttemplates/http%253A%252F%252Fopentosca.org%252Fartifacttemplates/DockerEngine_DockerEngine-Interface-w1/files/org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEngine.war, http://172.31.58.131:1337/csars/d1_w1-wip1.csar/content/artifacttemplates/http%253A%252F%252Fopentosca.org%252Fartifacttemplates/DockerEngine_DockerEngine-Interface-w1/files/org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEngine.zip], RelatesTo=DockerEngine_w1_0:InterfaceDockerEngine:startContainer:2021-10-01T12:58:08.375Z, ARTIFACTTEMPLATEID_QNAME={http://opentosca.org/artifacttemplates}DockerEngine_DockerEngine-Interface-w1, ReplyTo=http://engine-plan:9763/ode/processes/d1_w1-wip1.csarCallbackService1633092923691, INTERFACENAME_STRING=InterfaceDockerEngine, APIID_STRING=org.opentosca.bus.management.api.soaphttp, DEPLOYMENTLOCATION_STRING=172.31.58.131, SERVICETEMPLATEID_QNAME={http://www.example.org/tosca/servicetemplates}d1_w1-wip1, IMPLEMENTATION_ARTIFACT_NAME_STRING=DockerEngine-Interface, To=http://172.31.58.131:8081/invoker, ENDPOINT_URI=http://engine-ia:8080/172-31-58-131/d1_w1-wip1.csar/httpopentosca-orgnodetypeimplementationsDockerEngine-Implementation_w1/org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEngine/services/org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEnginePort, NODEINSTANCEID_STRING=15, TYPEIMPLEMENTATIONID_QNAME={http://opentosca.org/nodetypeimplementations}DockerEngine-Implementation_w1, INVOCATIONTYPE_STRING=SOAP/HTTP, MessageID=DockerEngine_w1_0:InterfaceDockerEngine:startContainer:2021-10-01T12:58:08.375Z, Accept=*/*, ARTIFACTTYPEID_STRING={http://opentosca.org/artifacttypes}WAR, HASOUTPUTPARAMS_BOOLEAN=true, Host=172.31.58.131:8081, OPERATIONNAME_STRING=startContainer, ARTIFACTSERVICEENDPOINT_STRING=/services/org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEnginePort, ParamsMode=HashMap, callback=http://engine-plan:9763/ode/processes/d1_w1-wip1.csarCallbackService1633092923691hqejbhcnphrgno3w8x7c49, CSARID=d1_w1-wip1.csar, PORT_TYPE_QNAME={http://opentosca.org/nodetypes}org_opentosca_NodeTypes_DockerEngine__InterfaceDockerEngine}
    Payload: <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><invokeResponse xmlns="http://siserver.org/schema">
    <MessageID>DockerEngine_w1_0:InterfaceDockerEngine:startContainer:2021-10-01T12:58:08.375Z</MessageID>
    <Params>
        <Param>
            <key>ContainerPorts</key>
            <value>5555-->5555</value>
        </Param>
        <Param>
            <key>ContainerIP</key>
            <value>ec2-3-35-68-199.ap-northeast-2.compute.amazonaws.com</value>
        </Param>
        <Param>
            <key>ContainerID</key>
            <value>11ed438cdd324ae9694d25883bb856e7afe10eef4f7407b203cd73b4562ad68e</value>
        </Param>
        <Param>
            <key>ContainerName</key>
            <value>ecstatic_wozniak</value>
        </Param>
        <Param>
            <key>MessageID</key>
            <value>4F9021EFB2F485B-0000000000000000</value>
        </Param>
    </Params>
</invokeResponse></soap:Body></soap:Envelope>
'''