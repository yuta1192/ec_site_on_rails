Datadog.configure do |c|
  c.use :rails, service_name: 'app'
  c.tracer hostname: 'ddagent',
           port: 8126
end
