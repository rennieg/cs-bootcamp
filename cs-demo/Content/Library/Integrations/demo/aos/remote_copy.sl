namespace: Integrations.demo.aos
flow:
  name: remote_copy
  inputs:
    - host
    - username
    - password
    - url
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
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename:
        x: 48
        y: 45
        navigate:
          44d5f35b-845a-d654-fe69-1d68863791f8:
            vertices:
              - x: 76
                y: 127
              - x: 91
                y: 128
              - x: 82
                y: 126
              - x: 86
                y: 117
              - x: 85
                y: 234
            targetId: http_client_action
            port: SUCCESS
      remote_secure_copy:
        x: 207
        y: 243
        navigate:
          7c7395ba-4f20-732e-50ca-a0ea0924202e:
            targetId: 6a3238f4-fe8a-eab7-0b61-1e7725ca014d
            port: SUCCESS
            vertices:
              - x: 244
                y: 243
      get_file:
        x: 37
        y: 239
    results:
      SUCCESS:
        6a3238f4-fe8a-eab7-0b61-1e7725ca014d:
          x: 211
          y: 61
