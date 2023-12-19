module ApplicationHelper

  def status_options
    ['sent', 'unpaid', 'paid']
  end

  def humanized_status(status)
    case status
    when 'sent'
      'Sent'
    when 'unpaid'
      'Unpaid'
    when 'paid'
      'Paid'
    else
      'Unknown'
    end
  end
end
