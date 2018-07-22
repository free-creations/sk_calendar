# frozen_string_literal: true

RSpec.describe SkCalendar::Config do
  it 'indicates the outfile' do
    expect(described_class.outfile).not_to be nil
  end

  it 'indicates the calendar input file' do
    expect(described_class.calendar_file).not_to be nil
  end

  it 'indicates the project root which is a directory' do
    expect(File).to be_directory(described_class.project_root)
  end

  it 'indicates the project root which exists' do
    expect(File).to be_exist(described_class.project_root)
  end

  it 'indicates the locale file which exists' do
    expect(File).to be_exist(described_class.locale)
  end

  it 'sets up the locale to be german' do
    described_class.setup
    expect(I18n.t('date.month_names')[1]).to eql('Januar')
  end
end
