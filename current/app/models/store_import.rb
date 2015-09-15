class StoreImport
  include ActiveModel::Model

  attr_accessor :file

  validates :file, presence: true

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save_to_current_shop(current_shop)
    if imported_stores(current_shop).map(&:valid?).all?
      imported_stores(current_shop).each(&:save!)
      true
    else
      imported_stores(current_shop).each_with_index do |store, index|
        store.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_stores(current_shop)
    @imported_stores ||= load_imported_stores(current_shop)
  end

  def load_imported_stores(current_shop)
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      store = Store.find_by_id(row["id"]) #|| current_shop.stores.build
      store = current_shop.stores.build unless current_shop.stores.include? store
      store.attributes = row.to_hash.slice(*Store.accessible_attributes)
      store
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end