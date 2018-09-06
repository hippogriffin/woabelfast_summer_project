# Key Pair for all hosts on DMZ environment
resource "aws_key_pair" "dmz_key" {
  key_name   = "${var.dmz_key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDo2FwJ/MCnHF71UTjq06GjBRWk0nhPCbsfwHCkiL3BbE+dOCOVG4iN6XfFftm/AIWMGTyiwyr5KvwkfTQ07vwH/zJDj+UAVomfMcRi0u6SrB+RDQ/cE9geDvQazK90QKCjGGpW+JhKBRbXw7viBPa0uciUKSult4QwqHRTlfDXCLL+iOwo3mOwyZ2WFcDPhpnTVZSFyzTwb1Dbpzowf1vC+OT9cN8LAMdFIY4hrwyuq6JkQfuznn4oPEZcAel0ZFVS3CD8hAcMy+pq/oVlhqU5z9n2pTln7f6vII1h3nc1QHb2K4nXCFyMDF+ihLnscBwfoDFRwtN2FS0XmHOjQbYz DMZ key"
}