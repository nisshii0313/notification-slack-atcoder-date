require 'nokogiri'
require 'open-uri'

def scrape_atcoder_contest_day
    host_domain = "https://atcoder.jp"
    directory = "/contests/?lang=ja"
    charset = nil

    html = open(host_domain + directory) do |f|
        charset = f.charset
        f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)
    table_header = nil
    contests = []
    doc.xpath('//div[@id="contest-table-upcoming"]//tr').each do |node|
        elements = node.xpath('.//td')
        if elements.empty?
            contests.push(node.xpath('.//th').map{ |e| e.content })
            contests[0].push("URL")
            next
        end
        url = elements[1].xpath('.//a').attribute('href').value
        name = elements[1].xpath('.//a').children.text
        elements = elements.map{ |e| e.content }
        elements[1] = name
        elements.push(host_domain + url)
        contests.push(elements)
    end
    return contests
end
