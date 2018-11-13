namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host: 169.254.10.117
    - username: root
    - password: admin@123
    - url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_java.sh'
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: get_file
    - get_file:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - destination_file: '${filename}'
            - method: GET
        publish:
          - output_0: output_0
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: /tmp
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename:
        x: 53
        y: 103
      get_file:
        x: 44
        y: 268
      remote_secure_copy:
        x: 243
        y: 259
        navigate:
          28d674fe-74a4-624e-54ad-c54331629849:
            targetId: 9582842a-0b24-1c17-8b09-7ef57c3c1bc1
            port: SUCCESS
    results:
      SUCCESS:
        9582842a-0b24-1c17-8b09-7ef57c3c1bc1:
          x: 231
          y: 101
