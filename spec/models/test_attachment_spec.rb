describe TestAttachment do
  it { should have_attached_file(:attachment) }

  it { should validate_attachment_presence(:attachment) }
end
