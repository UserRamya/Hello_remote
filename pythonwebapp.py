---
apiVersion: v1
kind: Namespace
metadata:
  name: pythonapp
---
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: pythonapp
  name: deployment
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: pythonapp-web
  replicas: 5
  template:
    metadata:
      labels:
        app.kubernetes.io/name: pythonapp-web
    spec:
      containers:
      - image: ramya321/first_image:latest
        imagePullPolicy: Always
        name: pythonapp-web
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  namespace: pythonapp
  name: service-pyapp
spec:
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
  type: NodePort
  selector:
    app.kubernetes.io/name: pythonapp-web
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: pythonapp
  name: ingress-pyapp
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
    - http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: service-pyapp
              port:
                number: 80
