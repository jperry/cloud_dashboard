describe InstancesDatatable do
  describe '#initialize' do
    params = {
      :sSortDir_0 => 'asc', :iSortCol_0 => "0", :iDisplayStart => "0",
      :iDisplayLength => "25", :sSearch => "", :sEcho => "1"
    }
    let(:view) { double("view", :params => params) }
    let(:datatable) { InstancesDatatable.new(view) }

    it 'receives a view as context' do
      expect(datatable.view).to eq(view)
    end
  end

  describe 'delegations' do
    params = {
      :sSortDir_0 => 'asc', :iSortCol_0 => "0", :iDisplayStart => "0",
      :iDisplayLength => "25", :sSearch => "", :sEcho => "1"
    }
    let(:view) { double("view", :params => params) }
    let(:datatable) { InstancesDatatable.new(view) }

    it 'delegates params call to view' do
      expect(view).to receive(:params).and_return({:sEcho => 4})
      datatable.params
    end
  end

  describe '#as_json', :vcr => { :cassette_name => 'all_instances' } do
    before(:each) do
      @params = {
        :sSortDir_0 => 'asc', :iSortCol_0 => "0", :iDisplayStart => "0",
        :iDisplayLength => "25", :sSearch => "", :sEcho => "1"
      }
    end
    let(:view) { double("view", :params => @params) }
    let(:datatable) { InstancesDatatable.new(view) }
    let(:total_records) { 5 }

    it 'returns a json hash' do
      expect(datatable.as_json).to be_a(Hash)
    end

    it 'has jquery.dataTables required keys' do
      expect(datatable.as_json.keys).to include(:sEcho, :iTotalRecords, :iTotalDisplayRecords, :aaData)
    end

    it 'returns total records' do
      expect(datatable.as_json[:iTotalRecords]).to eq(total_records)
    end

    it 'returns total records when nothing is filtered' do
      expect(datatable.as_json[:iTotalDisplayRecords]).to eq(total_records)
    end

    describe 'filtered' do
      it 'should filter results by given search' do
        # To show the set is filtered down
        expect(datatable.send(:all_instances).size).to eq(total_records)
        @params[:sSearch] = 'stopped'
        results = datatable.as_json
        expect(results[:aaData].size).to eq(1)
      end
    end

    describe 'sorting' do
      it 'should list last record first' do
        last_record = datatable.send(:all_instances).sort_by { |i| i[:name] }.last.values
        @params[:sSortDir_0] = 'desc'
        expect(datatable.as_json[:aaData].first).to eq(last_record)
      end

      0.upto(6).each do |col_id|
        it 'should be able to sort column #{col_id}' do
          @params[:iSortCol_0] = col_id
          expect { datatable.as_json[:aaData] }.to_not raise_exception
        end
      end
    end

    describe 'paginated' do
      it 'changing the display length reduces the data set' do
        @params[:iDisplayLength] = 1
        expect(datatable.as_json[:aaData].size).to eq(1)
      end
    end
  end
end
