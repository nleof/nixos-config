let
  alx =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDz0ZcVoI/G7ylW2+IBpmXhfmlItGvLP6kmUmWoFI2/pwjI24HmBcuH1L3qs4/6TetzW+r0OZFAQza+EnSa+szqZTrL8RY1KOJMHZ07xlGkiySLmTkMC0liIejgHANUvayGNssr3YIHfwwntHGi20EOmoHQ+DoIc7ZUJV/7Vb2lNJLsFGK56sd4VoQWv0seQzOvEgBfmj1AuN2w21d2J72jw9xJ3jiW2BnglhNHTO7GLwC+9ui0AwqFbm8XF9x44UHahaPIFONRlLwfOVIQegStTPSI/8d6wKasWQcxanw+pB/f0WyUjEs69CkNJXJKqFu4RfDUzLEaMqQzT03OxQ50630/cCZqb30E+1OdAAEOrKtoFUGEc44ryPbz8A3EUOBLx1S1b5tCMG9r6obIqucJdlr+aHBiT3POKRTD4Rcc+J0ro6l41FiVauXsX57FzgbpU8k4z8rCD42lLLCocYPc3KW+cOuSsUrAn9pM4LsAxqJR8MSDm9vtErqr7xAGZboiORWBQESSbHCquuiYVjS2irJDJskhHg/gKPiSrk0dr2IVDK6aPodV3CdgVDt5VczMyZjLz8CUjmdTh6yZuSU6fk1iddH6fNDqzXpZl9u/x9dDYhL7Z+ZyJ/Gn1iYZ7oVNX2t939/ktjckqSoTQOe2xU/MXcM7YDSmZRMv9XCraQ==";
  users = [ alx ];
  thinkpad =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyuc0Vly03Yxc1IZgozDb+wO9Z+uj+/SOIeRmHBDAqr root@thinkpad";
  desktop =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQGxJ1BI0evm6hFq9Xf1OhLgQEq0gLdJTPReHnXclCa root@desktop";
  vps =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkeHFUQpGEPU8Arh+dU6OBDg+cnfE9/p/f31tU584r5iBFlkJzzQCJoTPmKaswmZRJ8BgYHsOcThFfahTt2nh34kB2NocYVkzcNwD70RklxAwuR2mIpoOnu7EvrrdW+Ti5PhQrPKEkBOv7hsqC+bqzh+2G8U+aFMjJU9WA1SzpnmmPIlPJbqDLrfcZFNmNwqftGWZ9wVzTdZwlMVFwemURgkyTlXmZFXWcu3hmtK4rlH/D5cIDSVRdAiWsRy2MKOfD24du5Wb+uIDvNsQZmvAARGoO4pzmYPrE09uJjit66SOHgz8W0jtA87MEXrNj8EE856d5StcoCyfa2z0B4TV+bR2P4w9jhSY1xycjKYv3qxgcrks3VvBLrH0QesvR1vdi+Rq8URKcuwlrynb2OWtsc8B5V56m1B8PVXMDHmwbtjMFrQA8/7ITdnoZuommJFYp3M4B024Q1IAaOBh/wvWbBRTZt531/gw/lhZj0Lkmn5i1C6nceXXsshz6evI0x6U= root@debian-4gb-nbg1-1";
  hosts = [ thinkpad desktop vps ];
in {
  "samba.age".publicKeys = users ++ hosts;
  "miniflux.age".publicKeys = users ++ hosts;
}
