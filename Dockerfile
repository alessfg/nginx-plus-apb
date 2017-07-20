FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IGM1ZGZmMDIzLTg2ZTAtNDI1Yy04NGRlLTk5M2JlNDI1Yzc1NwpuYW1lOiBuZ2lueC1wbHVz\
LWFwYgppbWFnZTogbmdpbnhpbmMvbmdpbngtcGx1cy1hcGIKZGVzY3JpcHRpb246IFRoaXMgaXMg\
YSBzaW1wbGUgTkdJTlggUGx1cyBpbnN0YW5jZQpiaW5kYWJsZTogRmFsc2UKYXN5bmM6IG9wdGlv\
bmFsCm1ldGFkYXRhOgogIGRvY3VtZW50YXRpb25Vcmw6IGh0dHBzOi8vd3d3Lm5naW54LmNvbS9y\
ZXNvdXJjZXMvYWRtaW4tZ3VpZGUvCiAgaW1hZ2VVcmw6IGh0dHBzOi8vYXZhdGFyczIuZ2l0aHVi\
dXNlcmNvbnRlbnQuY29tL3UvODYyOTA3Mj92PTQmcz0yMDAKICBkZXBlbmRlbmNpZXM6IFsnL2Jp\
bi9zaDogL2Jpbi9ncmVwOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5J10KICBkaXNwbGF5TmFt\
ZTogTkdJTlggUGx1cwogIGxvbmdEZXNjcmlwdGlvbjogQW4gQVBCIHRoYXQgZGVwbG95cyBhbiBp\
bnN0YW5jZSBvZiBOR0lOWCBQbHVzCgpwYXJhbWV0ZXJzOiBbXQoKcmVxdWlyZWQ6IFtdCg=="

COPY playbooks /opt/apb/actions
COPY roles /opt/ansible/roles
USER apb
